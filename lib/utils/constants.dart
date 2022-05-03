//.............Authentication Urls..............
const baseURL = 'http://172.20.10.4:8000/api';

const loginURL = baseURL + '/auth/login';
const registerURL = baseURL + '/auth/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/auth/profile';

const insuaranceURL = baseURL + '/insuarances/';

//...............Errors...........
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';
