const setupPriceCalculation = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = Number(priceInput.value);

    if (!price) {
      document.getElementById("add-tax-price").innerHTML = "";
      document.getElementById("profit").innerHTML = "";
      return;
    }

    const tax = Math.floor(price * 0.1);
    const profit = price - tax;

    document.getElementById("add-tax-price").innerHTML = tax;
    document.getElementById("profit").innerHTML = profit;
  });
};

document.addEventListener("turbo:load", setupPriceCalculation);
document.addEventListener("turbo:render", setupPriceCalculation);