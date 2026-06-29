document.addEventListener("turbo:load", () => {
  const priceInput = document.getElementById("item-price");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = priceInput.value;

    if (price === "") {
      document.getElementById("add-tax-price").innerHTML = "";
      document.getElementById("profit").innerHTML = "";
      return;
    }

    const tax = Math.floor(price * 0.1);
    const profit = Math.floor(price - tax);

    document.getElementById("add-tax-price").innerHTML = tax;
    document.getElementById("profit").innerHTML = profit;
  });
});