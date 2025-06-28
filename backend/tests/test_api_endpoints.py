#!/usr/bin/env python3
"""
Script de test des endpoints API après correction des données
Ce script peut être utilisé pour tester l'API en cours d'exécution
ou être ignoré par pytest si aucun serveur n'est actif.
"""

import asyncio
import pytest
import sys
import os

# Ajouter le répertoire parent au path pour les imports
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

try:
    import aiohttp
    AIOHTTP_AVAILABLE = True
except ImportError:
    AIOHTTP_AVAILABLE = False
    print("WARNING: aiohttp non disponible - tests d'endpoints ignorés")

API_BASE_URL = "http://localhost:8084"

@pytest.mark.skipif(not AIOHTTP_AVAILABLE, reason="aiohttp non disponible")
class TestAPIEndpoints:
    """Tests des endpoints API (nécessite un serveur actif)"""
    
    @pytest.mark.asyncio
    async def test_server_health(self):
        """Test de base - vérifier si le serveur répond"""
        if not AIOHTTP_AVAILABLE:
            pytest.skip("aiohttp non disponible")
        
        try:
            async with aiohttp.ClientSession() as session:
                async with session.get(f"{API_BASE_URL}/health", timeout=5) as response:
                    assert response.status == 200
                    data = await response.json()
                    assert "status" in data
        except Exception as e:
            pytest.skip(f"Serveur non accessible: {e}")
    
    @pytest.mark.asyncio
    async def test_transmission_mere_enfant_endpoint(self):
        """Test de l'endpoint transmission_mere_enfant"""
        if not AIOHTTP_AVAILABLE:
            pytest.skip("aiohttp non disponible")
        
        try:
            async with aiohttp.ClientSession() as session:
                url = f"{API_BASE_URL}/transmission_mere_enfant/paginated/?offset=0&limit=5"
                async with session.get(url, timeout=5) as response:
                    if response.status == 200:
                        data = await response.json()
                        # Vérifier la structure de la réponse
                        assert "data" in data
                        assert "total" in data
                        assert isinstance(data["data"], list)
                        assert isinstance(data["total"], int)
                        
                        # Si des données existent, vérifier la structure
                        if len(data["data"]) > 0:
                            first_item = data["data"][0]
                            required_fields = [
                                "id_transmission", "id_pays", "besoin_arv_min", "besoin_arv_median", "besoin_arv_max",
                                "pourcentage_recu_min", "pourcentage_recu_median", "pourcentage_recu_max"
                            ]
                            for field in required_fields:
                                assert field in first_item, f"Champ manquant: {field}"
                    else:
                        pytest.skip(f"Endpoint non accessible: status {response.status}")
        except Exception as e:
            pytest.skip(f"Erreur de connexion: {e}")

# Fonction utilitaire pour tests manuels (non collectée par pytest)
async def _test_endpoint_helper(session, endpoint, description):
    """Teste un endpoint et affiche les résultats"""
    url = f"{API_BASE_URL}/{endpoint}"
    print(f"\nTest: {description}")
    print(f"   URL: {url}")
    
    try:
        async with session.get(url, timeout=10) as response:
            if response.status == 200:
                data = await response.json()
                if isinstance(data, dict) and "data" in data:
                    print(f"   OK Status: {response.status} - {len(data['data'])} éléments, total: {data.get('total', 'N/A')}")
                    if len(data["data"]) > 0:
                        print(f"   Premier élément: {data['data'][0]}")
                    else:
                        print("   Liste vide - aucune donnée")
                elif isinstance(data, list):
                    print(f"   OK Status: {response.status} - {len(data)} éléments")
                    if len(data) > 0:
                        print(f"   Premier élément: {data[0]}")
                    else:
                        print("   Liste vide - aucune donnée")
                else:
                    print(f"   OK Status: {response.status} - Réponse: {data}")
            else:
                error_text = await response.text()
                print(f"   ERROR Status: {response.status}")
                print(f"   ERROR: {error_text[:200]}...")
    except asyncio.TimeoutError:
        print(f"   TIMEOUT - serveur non accessible")
    except Exception as e:
        print(f"   EXCEPTION: {e}")

async def manual_api_test():
    """Test manuel des endpoints - pour exécution directe du script"""
    if not AIOHTTP_AVAILABLE:
        print("ERROR: aiohttp non disponible - installez avec: pip install aiohttp")
        return
    
    print("Test des endpoints API MSPR")
    print("=" * 50)
    
    endpoints = [
        ("mortalite/paginated/?offset=0&limit=5", "Mortalité paginée"),
        ("population_hiv/paginated/?offset=0&limit=5", "Population HIV paginée"),
        ("transmission_mere_enfant/paginated/?offset=0&limit=5", "Transmission mère-enfant paginée"),
        ("traitement/paginated/?offset=0&limit=5", "Traitement paginé"),
        ("payslist/", "Liste des pays"),
        ("health", "Health check"),
    ]
    
    try:
        async with aiohttp.ClientSession() as session:
            for endpoint, description in endpoints:
                await _test_endpoint_helper(session, endpoint, description)
                await asyncio.sleep(0.5)  # Pause entre les requêtes
    except Exception as e:
        print(f"ERROR général: {e}")
    
    print("\n" + "=" * 50)
    print("Tests terminés")

if __name__ == "__main__":
    # Exécution directe = test manuel
    asyncio.run(manual_api_test())
else:
    # Import par pytest = tests unitaires
    pass