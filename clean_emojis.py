#!/usr/bin/env python3
"""
Script de nettoyage des emojis dans TOUS les fichiers du projet
"""

import os
import re
from pathlib import Path

def remove_emojis_from_file(file_path):
    """Supprime tous les emojis d'un fichier"""
    try:
        # Essayer différents encodages pour maximiser la compatibilité
        encodings = ['utf-8', 'utf-8-sig', 'latin1', 'cp1252']
        content = None
        encoding_used = None
        
        for encoding in encodings:
            try:
                with open(file_path, 'r', encoding=encoding) as f:
                    content = f.read()
                encoding_used = encoding
                break
            except (UnicodeDecodeError, UnicodeError):
                continue
        
        if content is None:
            # Si aucun encodage ne fonctionne, c'est probablement un fichier binaire
            return False
        
        # Pattern pour détecter les emojis Unicode (étendu)
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
            "\U0001F170-\U0001F251"  # enclosed characters
            "\U0001F900-\U0001F9FF"  # supplemental symbols
            "\U0001FA00-\U0001FA6F"  # chess symbols
            "\U0001FA70-\U0001FAFF"  # symbols and pictographs extended A
            "\U00002934\U00002935"   # arrows
            "\U0001F004\U0001F0CF"   # mahjong and playing cards
            "\U0001F18E"             # negative squared ab
            "\U0001F191-\U0001F251"  # enclosed characters
            ""  # emojis couramment utilisés
            "]+", flags=re.UNICODE)
        
        original_length = len(content)
        cleaned_content = emoji_pattern.sub('', content)
        
        if len(cleaned_content) != original_length:
            # Écrire avec le même encodage que celui utilisé pour lire
            with open(file_path, 'w', encoding=encoding_used) as f:
                f.write(cleaned_content)
            return True
        else:
            return False
            
    except (PermissionError, IsADirectoryError):
        # Ignorer les fichiers inaccessibles ou les dossiers
        return False
    except Exception as e:
        print(f"Erreur avec {file_path}: {e}")
        return False

def clean_all_project_files():
    """Nettoie tous les fichiers du projet de manière récursive"""
    # Démarrer depuis le dossier racine du projet (parent du script actuel)
    project_root = Path(__file__).parent
    
    # Extensions de fichiers texte à traiter
    text_extensions = {
        '.py', '.js', '.ts', '.vue', '.html', '.css', '.scss', '.sass', '.less',
        '.json', '.xml', '.yml', '.yaml', '.md', '.txt', '.rst', '.ini', '.cfg',
        '.conf', '.log', '.sql', '.sh', '.bat', '.ps1', '.dockerfile', '.gitignore',
        '.env', '.properties', '.toml', '.lock', '.csv', '.tsv', '.jsx', '.tsx',
        '.php', '.rb', '.go', '.rs', '.cpp', '.c', '.h', '.hpp', '.java', '.kt',
        '.swift', '.m', '.mm', '.pl', '.r', '.scala', '.groovy', '.dart'
    }
    
    # Recherche récursive de tous les fichiers avec extensions texte
    all_files = []
    for ext in text_extensions:
        all_files.extend(project_root.rglob(f"*{ext}"))
    
    # Ajouter aussi les fichiers sans extension qui pourraient être du texte
    for file_path in project_root.rglob("*"):
        if file_path.is_file() and not file_path.suffix and file_path.name not in {'.gitkeep', '.DS_Store'}:
            # Vérifier si c'est probablement un fichier texte
            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    f.read(100)  # Essayer de lire les premiers caractères
                all_files.append(file_path)
            except (UnicodeDecodeError, PermissionError):
                pass  # Ignorer les fichiers binaires
    
    print("NETTOYAGE DES EMOJIS DANS TOUT LE PROJET")
    print("=" * 50)
    print(f"Dossier racine: {project_root}")
    print(f"Fichiers trouvés: {len(all_files)}")
    print("=" * 50)
    
    cleaned_count = 0
    processed_count = 0
    skipped_count = 0
    
    # Dossiers à ignorer
    ignore_dirs = {'.git', '__pycache__', '.vscode', 'node_modules', '.pytest_cache', 
                   'env_api', '.env', 'venv', 'env', 'dist', 'build', '.next', 
                   '.nuxt', 'coverage', '.coverage', '.mypy_cache', '.tox'}
    
    # Fichiers spécifiques à ignorer
    ignore_files = {'package-lock.json', 'yarn.lock', '.gitignore', 'LICENSE', 'CHANGELOG.md'}
    
    # Organiser les fichiers par dossier pour un affichage plus clair
    files_by_dir = {}
    for file_path in all_files:
        # Vérifier si le fichier est dans un dossier à ignorer
        if any(ignore_dir in file_path.parts for ignore_dir in ignore_dirs):
            skipped_count += 1
            continue
        
        # Vérifier si c'est un fichier à ignorer
        if file_path.name in ignore_files:
            skipped_count += 1
            continue
        
        parent_dir = file_path.parent.relative_to(project_root)
        if parent_dir not in files_by_dir:
            files_by_dir[parent_dir] = []
        files_by_dir[parent_dir].append(file_path)
    
    # Traiter les fichiers dossier par dossier
    for dir_path in sorted(files_by_dir.keys()):
        print(f"\n Dossier: {dir_path if str(dir_path) != '.' else '(racine)'}")
        print("-" * 30)
        
        for file_path in sorted(files_by_dir[dir_path]):
            processed_count += 1
            file_name = file_path.name
            file_ext = file_path.suffix or "(sans extension)"
            
            try:
                if remove_emojis_from_file(file_path):
                    cleaned_count += 1
                    print(f"   Nettoyé: {file_name} ({file_ext})")
                else:
                    print(f"   Aucun emoji: {file_name} ({file_ext})")
            except Exception as e:
                print(f"   Erreur avec {file_name}: {e}")
    
    print("\n" + "=" * 50)
    print(f"RÉSUMÉ FINAL:")
    print(f"  - Fichiers trouvés: {len(all_files)}")
    print(f"  - Fichiers ignorés: {skipped_count}")
    print(f"  - Fichiers traités: {processed_count}")
    print(f"  - Fichiers nettoyés: {cleaned_count}")
    print(f"  - Fichiers sans emojis: {processed_count - cleaned_count}")
    
    if cleaned_count > 0:
        print(f"   {cleaned_count} fichier(s) ont été nettoyés avec succès!")
    else:
        print("   Aucun emoji trouvé dans le projet!")
    
    print("=" * 50)
    
    return cleaned_count > 0

if __name__ == "__main__":
    try:
        print("Démarrage du script de nettoyage des emojis...")
        clean_all_project_files()
        print("Script terminé avec succès.")
    except Exception as e:
        print(f"ERREUR CRITIQUE: {e}")
        import traceback
        traceback.print_exc()
