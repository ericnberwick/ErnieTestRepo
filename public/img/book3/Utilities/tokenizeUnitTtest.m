clear;

str='can anyone help?';

tokens=tokenize(str);

assert(strcmp(tokens{1}, 'can'));
assert(strcmp(tokens{2}, 'anyone'));
assert(strcmp(tokens{3}, 'help?'));

str='can anyone help?';

tokens=tokenize(str, ' ');

assert(strcmp(tokens{1}, 'can'));
assert(strcmp(tokens{2}, 'anyone'));
assert(strcmp(tokens{3}, 'help?'));

str2='may I help you?';

c={str; str2};

tokens=tokenize(c);

assert(strcmp(tokens{1}{1}, 'can'));
assert(strcmp(tokens{1}{2}, 'anyone'));
assert(strcmp(tokens{1}{3}, 'help?'));

assert(strcmp(tokens{2}{1}, 'may'));
assert(strcmp(tokens{2}{2}, 'I'));
assert(strcmp(tokens{2}{3}, 'help'));
assert(strcmp(tokens{2}{4}, 'you?'));

str='a|b||c';
tokens=tokenize(str, '|');
assert(strcmp(tokens{1}, 'a'));
assert(strcmp(tokens{2}, 'b'));
assert(strcmp(tokens{3}, 'c'));



