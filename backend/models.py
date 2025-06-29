from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, DECIMAL, Text
from sqlalchemy.orm import relationship, Mapped, mapped_column
from typing import List, Optional
from database import Base
import datetime


class Country(Base):
    __tablename__ = "countries"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False, unique=True)
    who_region: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    iso_code: Mapped[Optional[str]] = mapped_column(String(3), nullable=True)
    created_at: Mapped[datetime.datetime] = mapped_column(DateTime, default=datetime.datetime.utcnow)
    updated_at: Mapped[datetime.datetime] = mapped_column(DateTime, default=datetime.datetime.utcnow, onupdate=datetime.datetime.utcnow)

    # Relations
    health_indicators: Mapped[List["HealthIndicator"]] = relationship(
        "HealthIndicator", back_populates="country"
    )


class IndicatorType(Base):
    __tablename__ = "indicator_types"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    name: Mapped[str] = mapped_column(String(255), nullable=False, unique=True)
    description: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    unit: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    created_at: Mapped[datetime.datetime] = mapped_column(DateTime, default=datetime.datetime.utcnow)

    # Relations
    health_indicators: Mapped[List["HealthIndicator"]] = relationship(
        "HealthIndicator", back_populates="indicator_type"
    )


class HealthIndicator(Base):
    __tablename__ = "health_indicators"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    country_id: Mapped[int] = mapped_column(Integer, ForeignKey("countries.id"), nullable=False)
    indicator_type_id: Mapped[int] = mapped_column(Integer, ForeignKey("indicator_types.id"), nullable=False)
    year: Mapped[int] = mapped_column(Integer, default=2023)
    value_type: Mapped[str] = mapped_column(String(100), nullable=False)  # 'received', 'needed', 'percentage', etc.
    value: Mapped[Optional[float]] = mapped_column(DECIMAL(15, 2), nullable=True)
    value_text: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)  # pour les valeurs comme "No data"
    confidence_min: Mapped[Optional[float]] = mapped_column(DECIMAL(15, 2), nullable=True)
    confidence_max: Mapped[Optional[float]] = mapped_column(DECIMAL(15, 2), nullable=True)
    confidence_median: Mapped[Optional[float]] = mapped_column(DECIMAL(15, 2), nullable=True)
    data_quality: Mapped[str] = mapped_column(String(50), default='good')
    source_file: Mapped[Optional[str]] = mapped_column(String(255), nullable=True)
    raw_value_text: Mapped[Optional[str]] = mapped_column(Text, nullable=True)  # stocke la valeur brute pour traçabilité
    created_at: Mapped[datetime.datetime] = mapped_column(DateTime, default=datetime.datetime.utcnow)
    updated_at: Mapped[datetime.datetime] = mapped_column(DateTime, default=datetime.datetime.utcnow, onupdate=datetime.datetime.utcnow)

    # Relations
    country: Mapped["Country"] = relationship("Country", back_populates="health_indicators")
    indicator_type: Mapped["IndicatorType"] = relationship("IndicatorType", back_populates="health_indicators")


class ETLMetadata(Base):
    __tablename__ = "etl_metadata"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    file_name: Mapped[str] = mapped_column(String(255), nullable=False)
    processing_date: Mapped[datetime.datetime] = mapped_column(DateTime, default=datetime.datetime.utcnow)
    records_processed: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    records_success: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    records_failed: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    processing_duration_seconds: Mapped[Optional[float]] = mapped_column(DECIMAL(10, 2), nullable=True)
    notes: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

# Authentification

class Utilisateur(Base):
    __tablename__ = "utilisateur"
    
    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    username: Mapped[str] = mapped_column(String(255), unique=True, index=True, nullable=False)
    hashed_password: Mapped[str] = mapped_column(String(255), nullable=False)
    role: Mapped[str] = mapped_column(String(50), nullable=False)
    rgpd_accept: Mapped[int] = mapped_column(Integer, nullable=False, default=0)  # 0: non accepté, 1: accepté
