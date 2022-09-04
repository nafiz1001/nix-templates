{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates = {

      rust = {
        path = ./rust;
        description = "Rust template, using Naersk";
      };

      go = {
        path = ./go;
        description = "Go template";
      };

      javascript = {
        path = ./javascript;
        description = "Javascript template";
      };

      python = {
        path = ./python;
        description = "Python template";
      };

    };
  };
}
