import axios from 'axios'
const axiosInstance = axios.create({
  baseURL: process.env.API_URL
})

if (localStorage.auth_token) {
  axiosInstance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`
}
export default axiosInstance
