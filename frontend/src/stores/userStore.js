import { defineStore } from 'pinia';

function getUserFromToken() {
  const token = localStorage.getItem('access_token');
  if (!token) return null;
  try {
    const payload = JSON.parse(atob(token.split('.')[1]));
    return payload.sub;
  } catch {
    return null;
  }
}

export const useUserStore = defineStore('user', {
  state: () => ({
    username: getUserFromToken(),
  }),
  actions: {
    setToken(token) {
      localStorage.setItem('access_token', token);
      this.username = getUserFromToken();
    },
    clearUser() {
      localStorage.removeItem('access_token');
      this.username = null;
    },
    refreshUser() {
      this.username = getUserFromToken();
    }
  }
});
