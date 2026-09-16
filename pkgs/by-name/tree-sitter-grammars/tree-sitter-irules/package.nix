{ tree-sitter, fetchFromGitHub }:
tree-sitter.buildGrammar {
  language = "irules";
  version = "0.0.0+rev=f6161d2";
  src = fetchFromGitHub {
    owner = "dekobon";
    repo = "tree-sitter-irules";
    rev = "f6161d2b0b24b8cbed9203f9993bd9ebbe84d510";
    hash = "sha256-tMy0/KZ5QgzJfLTVmFjsiwk1dnTn/RQNRTcEuQc5T5g=";
  };
  meta.homepage = "https://github.com/dekobon/tree-sitter-irules";
}
