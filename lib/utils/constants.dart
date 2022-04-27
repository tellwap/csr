//.............Authentication Urls..............
const baseURL = 'http://192.168.1.100:8000/api';

const loginURL = baseURL + '/auth/login';
const registerURL = baseURL + '/auth/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/auth/profile';

//...............Errors...........
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';
