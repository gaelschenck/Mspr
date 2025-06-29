#!/usr/bin/env python3
"""
Script de nettoyage des emojis dans les fichiers Python du backend
"""

import os
import re
from pathlib import Path

def remove_emojis_from_file(file_path):
    """Supprime tous les emojis d'un fichier"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Pattern pour détecter les emojis Unicode
        emoji_pattern = re.compile(
            "["
            "\U0001F600-\U0001F64F"  # emoticons
            "\U0001F300-\U0001F5FF"  # symbols & pictographs
            "\U0001F680-\U0001F6FF"  # transport & map symbols
            "\U0001F1E0-\U0001F1FF"  # flags (iOS)
            "\U00002700-\U000027BF"  # dingbats
            "\U0001f926-\U0001f937"  # additional emoticons
            "\U00010000-\U0010ffff"  # supplementary
            "\u2640-\u2642"          # gender symbols
            "\u2600-\u2B55"          # misc symbols
            "\u200d"                 # zero width joiner
            "\u23cf"                 # eject button
            "\u23e9"                 # fast forward
            "\u231a"                 # watch
            "\ufe0f"                 # variation selector
            "\u3030"                 # wavy dash
            "]+", flags=re.UNICODE)
        
        original_length = len(content)
        cleaned_content = emoji_pattern.sub('', content)
        
        if len(cleaned_content) != original_length:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(cleaned_content)
            print(f"Nettoyé: {file_path}")
            return True
        else:
            return False
            
    except Exception as e:
        print(f"Erreur avec {file_path}: {e}")
        return False

def clean_backend_files():
    """Nettoie tous les fichiers Python du backend"""
    backend_dir = Path(__file__).parent
    python_files = list(backend_dir.glob("*.py"))
    
    print("NETTOYAGE DES EMOJIS DANS LE BACKEND")
    print("=" * 40)
    
    cleaned_count = 0
    
    for py_file in python_files:
        if remove_emojis_from_file(py_file):
            cleaned_count += 1
    
    print(f"\nTerminé: {cleaned_count} fichiers nettoyés sur {len(python_files)}")
    return cleaned_count > 0

if __name__ == "__main__":
    clean_backend_files()
