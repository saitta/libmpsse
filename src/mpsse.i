%module pylibmpsse
%{
#include "mpsse.h"
%}

/* this typemap is for using python 3 bytes */
%typemap(in) (char *data, int size)
{
  if (!PyBytes_Check($input)) {
    PyErr_SetString(PyExc_ValueError, "Expecting a bytes object");
    return NULL;
  }
  $2 = PyBytes_Size($input);
  $1 = PyBytes_AsString($input);
}

/*  A typemap example with list of integers
%typemap(in) (char *data, int size)
{
  int i;
  if (!PyList_Check($input)) {
    PyErr_SetString(PyExc_ValueError, "Expecting a list");
    return NULL;
  }
  $2 = PyList_Size($input);
  $1 = (char *) malloc(($2)*sizeof(char));
  for (i = 0; i < $2; i++) {
    PyObject *s = PyList_GetItem($input,i);
    if (!PyInt_Check(s)) {
        free($1);
        PyErr_SetString(PyExc_ValueError, "List items must be integers");
        return NULL;
    }
    $1[i] = (uint8_t) (PyInt_AsLong(s) & 0xFF);
  }
}

%typemap(freearg) (char *data, int size)
{
   if ($1) free($1);
}
*/

%typemap(out) swig_string_data
{
        $result = PyBytes_FromStringAndSize($1.data, $1.size);
        free($1.data);
}

%include "mpsse.h"
