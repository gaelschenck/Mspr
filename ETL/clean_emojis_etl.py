#!/usr/bin/env python3
# =============================================================================
# Script : clean_emojis_etl.py
# Description : Supprime tous les emojis des scripts ETL
# =============================================================================

import os
import re
from pathlib import Path

def clean_emojis_in_file(file_path):
    """Supprime les emojis d'un fichier Python"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Mapping des emojis vers du texte
        emoji_replacements = {
            '🔄': '[PROCESSING]',
            '✅': '[SUCCESS]',
            '❌': '[ERROR]',
            '⚠️': '[WARNING]',
            '🚀': '[START]',
            '🟢': '',
            '🟡': '',
            '🔵': '',
            '📚': '',
            '📊': '',
            '✨': '',
            '⏳': '[RUNNING]',
            '🎯': '[TARGET]'
        }
        
        # Remplace les emojis
        original_content = content
        for emoji, replacement in emoji_replacements.items():
            content = content.replace(emoji, replacement)
        
        # Supprime les autres emojis Unicode
        emoji_pattern = re.compile(
            "["
            "\U0001F600-\U0001F64F"  # emoticons
            "\U0001F300-\U0001F5FF"  # symbols & pictographs
            "\U0001F680-\U0001F6FF"  # transport & map symbols
            "\U0001F1E0-\U0001F1FF"  # flags (iOS)
            "\U00002702-\U000027B0"
            "\U000024C2-\U0001F251"
            "]+", flags=re.UNICODE)
        
        content = emoji_pattern.sub('', content)
        
        # Sauvegarde seulement si des changements ont été faits
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Nettoyé: {file_path.name}")
            return True
        else:
            print(f"Aucun emoji trouvé: {file_path.name}")
            return False
            
    except Exception as e:
        print(f"Erreur lors du nettoyage de {file_path}: {e}")
        return False

def main():
    """Nettoie tous les fichiers ETL"""
    etl_dir = Path('.')
    python_files = list(etl_dir.glob('etl_*.py'))
    
    print(f"Nettoyage de {len(python_files)} fichiers ETL...")
    
    cleaned_count = 0
    for file_path in python_files:
        if clean_emojis_in_file(file_path):
            cleaned_count += 1
    
    print(f"Terminé: {cleaned_count} fichiers modifiés")

if __name__ == "__main__":
    main()
