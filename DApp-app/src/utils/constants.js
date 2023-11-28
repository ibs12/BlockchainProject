export const routerPush = (self, name) => {
  self.$router.push({ name: name }).catch(() => {});
};
