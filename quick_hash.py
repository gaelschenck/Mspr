#!/usr/bin/env python3
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Générons des hashes propres
print("Nouveaux hashes bcrypt :")
print(f"adminfr: {pwd_context.hash('adminfr')}")
print(f"userfr: {pwd_context.hash('userfr')}")
print(f"adminus: {pwd_context.hash('adminus')}")
print(f"userus: {pwd_context.hash('userus')}")
print(f"adminch: {pwd_context.hash('adminch')}")
print(f"userch: {pwd_context.hash('userch')}")
