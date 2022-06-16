//.............Authentication Urls..............
//const baseURL = 'http://10.0.2.2:8000/api';
const baseURL = 'http://carservicereminder.tk/api';

const loginURL = baseURL + '/auth/login';
const registerURL = baseURL + '/auth/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/auth/profile';

const insuaranceURL = baseURL + '/insuarances/';
const alertURL = baseURL + '/insuarances/monitoring';

//...............Errors...........
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';
