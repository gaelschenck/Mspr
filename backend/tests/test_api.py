import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))

from fastapi.testclient import TestClient
from main import app
from unittest.mock import AsyncMock, MagicMock
from database import get_db

# Mock de la dépendance get_db pour éviter la BDD réelle
async def override_get_db():
    # On simule un objet de session asynchrone avec execute() qui retourne un mock
    mock_session = AsyncMock()
    mock_result = MagicMock()
    # Simule le retour d'une liste de pays fictifs
    mock_result.scalars().all.return_value = [
        type('Pays', (), {'id_pays': 1, 'nom_pays': 'France', 'region': 'Europe'})()
    ]
    mock_session.execute.return_value = mock_result
    yield mock_session

app.dependency_overrides[get_db] = override_get_db

def test_root():
    response = TestClient(app).get("/")
    assert response.status_code == 200
    assert "message" in response.json()

def test_get_pays():
    response = TestClient(app).get("/pays/")
    assert response.status_code == 200
    assert isinstance(response.json(), list)
    assert response.json()[0]["nom_pays"] == "France"
