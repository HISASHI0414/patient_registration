// app/javascript/packs/terms_modal.js
document.addEventListener('turbolinks:load', () => {
  const termsModal = document.getElementById('termsModal');
  const termsContent = document.getElementById('termsContent');
  const acceptButton = document.getElementById('acceptTermsButton');
  const openTermsButton = document.getElementById('openTermsButton');
  const signupButton = document.getElementById('signupButton');

  if (!termsModal || !termsContent || !acceptButton || !openTermsButton || !signupButton) return;

  openTermsButton.addEventListener('click', () => {
    termsModal.style.display = 'block';
  });

  termsContent.addEventListener('scroll', () => {
    if (termsContent.scrollTop + termsContent.clientHeight >= termsContent.scrollHeight) {
      acceptButton.disabled = false;
    }
  });

  acceptButton.addEventListener('click', () => {
    document.getElementById('termsAccepted').value = 'true';
    termsModal.style.display = 'none';
    signupButton.disabled = false;
  });
});
