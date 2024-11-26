export const unsafeCons = (a) => (arr) => {
  arr.unshift(a);
  return arr;
};

export const unsafeSnoc = (a) => (arr) => {
  arr.push(a);
  return arr;
};