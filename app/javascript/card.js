const pay = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const token = "tok_sample"; // 仮トークン

    document.getElementById("token").value = token;
    form.submit();
  });
};

window.addEventListener("turbo:load", pay);