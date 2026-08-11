// URL del Webhook de Google Apps Script (Debe ser el mismo que usa Catalog)
const GOOGLE_SCRIPT_URL_EMPRESA = "https://script.google.com/macros/s/AKfycby1Is_vvjF8wijpZ94jxPBSaDGNyS2QpS0oPf7OneSalzpNOS1i3JoXrQVkYixwuKeCvQ/exec";

async function submitEmpresaForm(event) {
    event.preventDefault();
    
    // Obtener los valores del formulario
    const name = document.getElementById('form-field-name').value;
    const email = document.getElementById('form-field-email').value;
    const phone = document.getElementById('form-field-9175f13').value;
    const message = document.getElementById('form-field-message').value;
    const statusMsg = document.getElementById('empresaStatusMessage');
    const submitBtn = document.getElementById('empresaSubmitBtn');
    
    if (GOOGLE_SCRIPT_URL_EMPRESA === "REEMPLAZAR_CON_TU_URL_DE_APPS_SCRIPT") {
        statusMsg.innerText = 'Error: Falta configurar la URL de Google Apps Script.';
        statusMsg.className = 'demo-status-message demo-status-error';
        return;
    }
    
    // Preparar datos
    const formData = new URLSearchParams();
    formData.append('nombre', name);
    formData.append('email', email);
    formData.append('telefono', phone);
    formData.append('mensaje', message);
    
    const formElement = document.getElementById('empresaForm');
    const producto = formElement.getAttribute('data-producto') || 'Empresa';
    formData.append('producto', producto); 

    // Cambiar estado del botón
    submitBtn.innerText = 'Enviando...';
    submitBtn.disabled = true;
    statusMsg.innerText = '';
    
    try {
        const response = await fetch(GOOGLE_SCRIPT_URL_EMPRESA, {
            method: 'POST',
            body: formData,
            mode: 'no-cors' 
        });
        
        statusMsg.innerText = '¡Mensaje enviado correctamente! Nos pondremos en contacto pronto.';
        statusMsg.className = 'demo-status-message demo-status-success';
        
        document.getElementById('empresaForm').reset();
        setTimeout(() => {
            submitBtn.innerText = 'Enviar Mensaje';
            submitBtn.disabled = false;
        }, 3000);
        
    } catch (error) {
        statusMsg.innerText = 'Hubo un error de conexión. Intenta nuevamente.';
        statusMsg.className = 'demo-status-message demo-status-error';
        submitBtn.innerText = 'Enviar Mensaje';
        submitBtn.disabled = false;
    }
}
