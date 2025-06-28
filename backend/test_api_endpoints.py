#!/usr/bin/env python3
"""
Script de test des endpoints API après correction des données
"""

import asyncio
import aiohttp
import json

API_BASE_URL = "http://localhost:8080/api/fr"

async def test_endpoint(session, endpoint, description):
    """Teste un endpoint et affiche les résultats"""
    url = f"{API_BASE_URL}/{endpoint}"
    print(f"\n🧪 Test: {description}")
    print(f"   URL: {url}")
    
    try:
        async with session.get(url) as response:
            if response.status == 200:
                data = await response.json()
                if isinstance(data, list):
                    print(f"   ✅ Status: {response.status} - {len(data)} éléments")
                    if len(data) > 0:
                        print(f"   📋 Premier élément: {json.dumps(data[0], indent=2, ensure_ascii=False)}")
                    else:
                        print("   ⚠️  Liste vide - aucune donnée")
                else:
                    print(f"   ✅ Status: {response.status} - Réponse: {data}")
            else:
                error_text = await response.text()
                print(f"   ❌ Status: {response.status}")
                print(f"   ❌ Erreur: {error_text[:200]}...")
    except Exception as e:
        print(f"   ❌ Exception: {e}")

async def main():
    """Teste tous les endpoints de pagination"""
    print("🚀 Test des endpoints API MSPR")
    print("=" * 50)
    
    endpoints = [
        ("mortalite/paginated/?offset=0&limit=5", "Mortalité paginée"),
        ("population_hiv/paginated/?offset=0&limit=5", "Population HIV paginée"),
        ("transmission_mere_en_enfant/paginated/?offset=0&limit=5", "Transmission mère-enfant paginée"),
        ("traitement/paginated/?offset=0&limit=5", "Traitement paginé"),
        ("payslist/", "Liste des pays"),
        ("health", "Health check"),
    ]
    
    async with aiohttp.ClientSession() as session:
        for endpoint, description in endpoints:
            await test_endpoint(session, endpoint, description)
            await asyncio.sleep(0.5)  # Pause entre les requêtes
    
    print("\n" + "=" * 50)
    print("✅ Tests terminés")

if __name__ == "__main__":
    asyncio.run(main())
