export const argv = function () {
  // Dropping one to make the arg handling of js similar to go's.
  // The issue here is that node scripts are provided with the location
  // of the node process and the script that was run
  return process.argv.slice(1);
};

export const exit = function () {
  return function () {};
};
