export const reverseCodeUnits = (s) => {
  let i = s.length;
  let result = "";

  while (i) {
    result += s[--i];
  }

  return result;
};