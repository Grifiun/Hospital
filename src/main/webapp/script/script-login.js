var username;
var pass;

function iniciarSesion(){  
    inicializarVar();
    if(username == "" ){
        alert("Faltan datos por rellenar"); 
    }
    else{        
        alert("Entraste con exito crack");         
    }    
}
function inicializarVar(){
    username = document.getElementById("username").value.toString();
    pass = document.getElementById("pass").value.toString();
}