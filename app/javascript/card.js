const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);

  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        alert("カード情報が正しくありません");
      } else {
        const token = response.id;

        const tokenInput = document.createElement("input");
        tokenInput.type = "hidden";
        tokenInput.name = "token";
        tokenInput.value = token;

        form.appendChild(tokenInput);

        form.submit();
      }
    });
  });
};

document.addEventListener("turbo:load", pay);
document.addEventListener("turbo:render", pay);