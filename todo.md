- [ ] > We need to at least point them to the right line. Even better would be the beginning and end column so they know where in the line. Even better than that is to show the user the offending line, like:
  ```julia
  Error: Unexpected "," in argument list.

      15 | function(first, second,);
                                 ^-- Here.
  ```
- [ ] > The code reports each invalid character separately, so this shotguns the user with a blast of errors if they accidentally paste a big blob of weird text. Coalescing a run of invalid characters into a single error would give a nicer user experience.
- [ ] 