#!/usr/bin/env python3
"""
Script pour générer les hashes bcrypt corrects pour les mots de passe
"""
from passlib.context import CryptContext

# Configuration bcrypt identique à celle du backend
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Mots de passe en clair
passwords = {
    "adminfr": "adminfr",
    "userfr": "userfr", 
    "adminus": "adminus",
    "userus": "userus",
    "adminch": "adminch",
    "userch": "userch"
}

print("=== NOUVEAUX HASHES BCRYPT ===\n")

for username, password in passwords.items():
    hash_password = pwd_context.hash(password)
    print(f"Utilisateur: {username}")
    print(f"Mot de passe: {password}")
    print(f"Hash bcrypt: {hash_password}")
    print("-" * 80)

print("\n=== REQUÊTES SQL DE MISE À JOUR ===\n")

# Génération des requêtes SQL par pays
countries = {
    "fr": [("adminfr", "adminfr"), ("userfr", "userfr")],
    "us": [("adminus", "adminus"), ("userus", "userus")], 
    "ch": [("adminch", "adminch"), ("userch", "userch")]
}

for country, users in countries.items():
    print(f"-- Mise à jour pour {country.upper()}")
    for username, password in users:
        hash_password = pwd_context.hash(password)
        print(f"UPDATE utilisateur SET hashed_password = '{hash_password}' WHERE username = '{username}';")
    print()
