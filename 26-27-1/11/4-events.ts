// "function factory": függvényt adunk vissza
const makeFormatter = (a: string, c: string) => (b: string) => a + b + c;
const wrapParens = makeFormatter('(', ')');
// wrapParens('abc') === '(abc)'

// transzformálunk egy függvényt
const memoize = <K, V>(f: (key: K) => V): typeof f => {
    const memo = new Map<K, V>();
    return key => (memo.has(key) ? memo : memo.set(key, f(key))).get(key)!;
};
const wrapBraces = memoize(makeFormatter('{', '}'));
// wrapBraces('abc') === '{abc}'

// eseménykezeléshez is magasabb rendű függvényeket (callback) használunk
const textarea = document.querySelector('textarea')!;
textarea.addEventListener('input', () => console.log(wrapBraces(textarea.value)));
