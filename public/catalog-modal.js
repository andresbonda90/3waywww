// variables para el Math Captcha
let captchaAnswer = 0;

// URL del Webhook de Google Apps Script
// IMPORTANTE: REEMPLAZAR ESTO CON LA URL QUE TE DIO GOOGLE APPS SCRIPT
const GOOGLE_SCRIPT_URL = "https://script.google.com/macros/s/AKfycby1Is_vvjF8wijpZ94jxPBSaDGNyS2QpS0oPf7OneSalzpNOS1i3JoXrQVkYixwuKeCvQ/exec";

function generateCaptcha() {
    const num1 = Math.floor(Math.random() * 10) + 1;
    const num2 = Math.floor(Math.random() * 10) + 1;
    captchaAnswer = num1 + num2;
    document.getElementById('demoCaptchaLabel').innerText = `Por seguridad: ¿Cuánto es ${num1} + ${num2}?`;
    document.getElementById('demoCaptcha').value = '';
}

function openDemoModal() {
    const modal = document.getElementById('demoModal');
    modal.style.display = 'flex';
    // Forzar reflow para la transición de opacidad
    modal.offsetHeight; 
    modal.classList.add('active');
    
    // Limpiar formulario y generar captcha
    document.getElementById('demoForm').reset();
    document.getElementById('demoStatusMessage').innerText = '';
    generateCaptcha();
}

function closeDemoModal() {
    const modal = document.getElementById('demoModal');
    modal.classList.remove('active');
    setTimeout(() => {
        modal.style.display = 'none';
    }, 300); // esperar que termine la transición
}

async function submitDemoForm(event) {
    event.preventDefault();
    
    const name = document.getElementById('demoName').value;
    const email = document.getElementById('demoEmail').value;
    const captchaInput = parseInt(document.getElementById('demoCaptcha').value);
    const statusMsg = document.getElementById('demoStatusMessage');
    const submitBtn = document.getElementById('demoSubmitBtn');
    
    // Validar Captcha
    if (captchaInput !== captchaAnswer) {
        statusMsg.innerText = 'El resultado de la suma es incorrecto. Intenta de nuevo.';
        statusMsg.className = 'demo-status-message demo-status-error';
        generateCaptcha();
        return;
    }

    if (GOOGLE_SCRIPT_URL === "REEMPLAZAR_CON_TU_URL_DE_APPS_SCRIPT") {
        statusMsg.innerText = 'Error: Falta configurar la URL de Google Apps Script.';
        statusMsg.className = 'demo-status-message demo-status-error';
        return;
    }
    
    // Preparar datos (simulando formulario URL-encoded)
    const formData = new URLSearchParams();
    formData.append('nombre', name);
    formData.append('email', email);
    formData.append('producto', 'Catalog'); // Identificador para la columna del Excel

    // Cambiar estado del botón
    submitBtn.innerText = 'Enviando...';
    submitBtn.disabled = true;
    statusMsg.innerText = '';
    
    try {
        const response = await fetch(GOOGLE_SCRIPT_URL, {
            method: 'POST',
            body: formData,
            mode: 'no-cors' // Google Apps Script requiere esto si no se manejan bien los headers CORS
        });
        
        // Al usar no-cors, la respuesta siempre es opaca, asumimos éxito si no lanza catch
        statusMsg.innerText = '¡Solicitud enviada correctamente! Nos pondremos en contacto pronto.';
        statusMsg.className = 'demo-status-message demo-status-success';
        
        // Limpiar el form y cerrar tras unos segundos
        document.getElementById('demoForm').reset();
        setTimeout(() => {
            closeDemoModal();
            submitBtn.innerText = 'Enviar Solicitud';
            submitBtn.disabled = false;
        }, 3000);
        
    } catch (error) {
        statusMsg.innerText = 'Hubo un error de conexión. Intenta nuevamente.';
        statusMsg.className = 'demo-status-message demo-status-error';
        submitBtn.innerText = 'Enviar Solicitud';
        submitBtn.disabled = false;
    }
}
