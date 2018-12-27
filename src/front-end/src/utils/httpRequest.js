import axios from 'axios';

const instanceConfig = {
    timeout: 5000,
    baseURL: '/api'
  };
  
export const httpRequest = axios.create(instanceConfig); // 请求对象，通常情况下使用此请求器

httpRequest.interceptors.response.use(
	(response) => response,
	(error) => {
		const { response } = error;
		return Promise.reject(response);
	}
);