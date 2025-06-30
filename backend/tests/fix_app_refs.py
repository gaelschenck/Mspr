#!/usr/bin/env python3
import re

# Lire le fichier
with open('test_ml_endpoints.py', 'r', encoding='utf-8') as f:
    content = f.read()

# Remplacer 'app=app' par 'app=test_app'
content = re.sub(r'app=app\)', 'app=test_app)', content)

# Écrire le fichier
with open('test_ml_endpoints.py', 'w', encoding='utf-8') as f:
    f.write(content)

print(' Toutes les références app=app ont été remplacées par app=test_app')
