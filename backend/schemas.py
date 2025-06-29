from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional, List


### SCHEMAS POUR COUNTRIES (PAYS)
class CountryBase(BaseModel):
    name: str = Field(..., min_length=2, max_length=255)
    who_region: Optional[str] = Field(None, max_length=100)
    iso_code: Optional[str] = Field(None, max_length=3)


class CountryCreate(CountryBase):
    pass


class Country(CountryBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


### SCHEMAS POUR INDICATOR_TYPES
class IndicatorTypeBase(BaseModel):
    name: str = Field(..., min_length=3, max_length=255)
    description: Optional[str] = None
    unit: Optional[str] = Field(None, max_length=100)


class IndicatorTypeCreate(IndicatorTypeBase):
    pass


class IndicatorType(IndicatorTypeBase):
    id: int
    created_at: datetime

    class Config:
        from_attributes = True


### SCHEMAS POUR HEALTH_INDICATORS
class HealthIndicatorBase(BaseModel):
    country_id: int
    indicator_type_id: int
    year: int = Field(default=2023, ge=1900, le=2100)
    value_type: str = Field(..., min_length=1, max_length=100)
    value: Optional[float] = None
    value_text: Optional[str] = Field(None, max_length=255)
    confidence_min: Optional[float] = None
    confidence_max: Optional[float] = None
    confidence_median: Optional[float] = None
    data_quality: str = Field(default="good", max_length=50)
    source_file: Optional[str] = Field(None, max_length=255)
    raw_value_text: Optional[str] = None


class HealthIndicatorCreate(HealthIndicatorBase):
    pass


class HealthIndicator(HealthIndicatorBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


### SCHEMAS POUR ETL_METADATA
class ETLMetadataBase(BaseModel):
    file_name: str = Field(..., max_length=255)
    records_processed: Optional[int] = None
    records_success: Optional[int] = None
    records_failed: Optional[int] = None
    processing_duration_seconds: Optional[float] = None
    notes: Optional[str] = None


class ETLMetadataCreate(ETLMetadataBase):
    pass


class ETLMetadata(ETLMetadataBase):
    id: int
    processing_date: datetime

    class Config:
        from_attributes = True


### SCHEMAS POUR PRÉDICTION
class PredictionRequest(BaseModel):
    region: Optional[str] = None
    country: Optional[str] = None
    indicator_type: str = Field(..., description="Type d'indicateur à prédire")
    value_type: Optional[str] = Field(None, description="Type de valeur spécifique")


class TrainingRequest(BaseModel):
    dataframe: dict = Field(..., description="DataFrame au format dictionnaire")
    target_column: str = Field(..., description="Colonne cible à prédire")


class PredictionResponse(BaseModel):
    prediction: List[float]
    labels: List[float]
    message: str
    rmse: float
    r2: float
    future_prediction: Optional[float] = None
    future_year: Optional[int] = None


### SCHEMAS POUR REQUÊTES COMPLEXES
class HealthDataQuery(BaseModel):
    countries: Optional[List[str]] = None
    indicator_types: Optional[List[str]] = None
    who_regions: Optional[List[str]] = None
    years: Optional[List[int]] = None
    value_types: Optional[List[str]] = None
    min_value: Optional[float] = None
    max_value: Optional[float] = None


class HealthDataSummary(BaseModel):
    total_countries: int
    total_indicators: int
    indicators_with_values: int
    data_completeness_rate: float
    year_range: str
    who_regions: List[str]


### SCHEMAS AVEC RELATIONS
class CountryWithIndicators(Country):
    health_indicators: List[HealthIndicator] = []


class IndicatorTypeWithData(IndicatorType):
    health_indicators: List[HealthIndicator] = []


class HealthIndicatorDetailed(HealthIndicator):
    country: Country
    indicator_type: IndicatorType


### AUTHENTIFICATION
class UtilisateurBase(BaseModel):
    username: str


class UtilisateurCreate(UtilisateurBase):
    password: str
    role: str


class UtilisateurOut(UtilisateurBase):
    id: int
    role: str

    class Config:
        from_attributes = True