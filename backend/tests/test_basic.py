#!/usr/bin/env python3
"""
Test simple pour vérifier que pytest fonctionne
"""

import pytest

def test_basic_math():
    """Test de base pour vérifier que pytest fonctionne"""
    assert 1 + 1 == 2
    assert 2 * 3 == 6
    assert 10 / 2 == 5

def test_string_operations():
    """Test des opérations string de base"""
    test_string = "MSPR Backend"
    assert "Backend" in test_string
    assert test_string.lower() == "mspr backend"
    assert len(test_string) > 0

def test_list_operations():
    """Test des opérations de liste de base"""
    test_list = [1, 2, 3, 4, 5]
    assert len(test_list) == 5
    assert test_list[0] == 1
    assert test_list[-1] == 5
    assert sum(test_list) == 15

class TestBasicFunctionality:
    """Classe de tests pour fonctionnalités de base"""
    
    def test_dict_operations(self):
        """Test des opérations de dictionnaire"""
        test_dict = {"id": 1, "name": "test", "active": True}
        assert test_dict["id"] == 1
        assert test_dict.get("name") == "test"
        assert test_dict.get("missing", "default") == "default"
    
    def test_data_types(self):
        """Test des types de données"""
        assert isinstance(42, int)
        assert isinstance("hello", str)
        assert isinstance([1, 2, 3], list)
        assert isinstance({"key": "value"}, dict)
        assert isinstance(True, bool)

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
