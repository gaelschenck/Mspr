import axios from 'axios';

const apiClient = axios.create({
  baseURL: 'http://localhost:8000', // Change cette URL si ton backend est hébergé ailleurs.
  headers: {
    'Content-Type': 'application/json',
  },
});

export default apiClient;