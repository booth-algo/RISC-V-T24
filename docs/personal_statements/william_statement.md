# Personal Statement: William Huynh

**Name:** William Huynh  
**CID:** 02271593  
**Github username:** saturn691  

## Summary

- I was the **main tester** for the team. Before or after reading this section,
I heavily encourage checking out the [testbench](../../tb), written 
primarily by me. More information on the section can be found 
[here](../team_statement_sections/testing.md).

- I was also in charge of code reviews, did a lot of refactoring and debugging,
which was often done alongside Kevin (@booth-algo) on calls or in-person.

## Contributions

The evidence for the [summary](#summary) section is linked below.

| Activity           | Link
| ------------------ |-----------------------------------------------------
| Writing Tests      | [Example](https://github.com/booth-algo/RISC-V-T24/pull/20) 
| Code Review        | [Example](https://github.com/booth-algo/RISC-V-T24/pull/8)  
| Refactoring        | [Example](https://github.com/booth-algo/RISC-V-T24/commit/7d7c6236a89176b0b1c39986e936943954aca37e)  
| Pipeline Debugging | [Example](https://github.com/booth-algo/RISC-V-T24/commit/3b5122d68dd4ef15d340c3e45828db638e97da53)  

I also worked on the RTL, primarily after Lab4. Here are some of my main 
contributions:

### General

- Introduced the use of branches and tagging to the team.
- [Introduced CI (GitHub Actions).](https://github.com/booth-algo/RISC-V-T24/commit/e54ccb36dd0e178ce7d2d33e432cf981efefee37).
- [Created industry standard testing (GTest).](https://github.com/booth-algo/RISC-V-T24/commit/a2b177139707acfb482ee30f0e28641d65d4e017).
  Once again, I encourage checking the [`test folder`](../../tb/test/)
- Pipelined the testing process through bash scriping
  [doit.sh](https://github.com/booth-algo/RISC-V-T24/commit/3c00492c35f810ab3cbe71c34fc84aca1d494801),
  [compile.sh](https://github.com/booth-algo/RISC-V-T24/commit/e61392896bef151a95739cd8ffe378ef269152c2)

From this point, I will **not** focus on the testbench commits, but rather RTL 
work, for I have said enough. 

(Please check it out [here](../../tb), if you haven't already!)

### Single-Cycle

- [Finished implementation of lab4.](https://github.com/booth-algo/RISC-V-T24/commit/7849572c0b5ffa63201225f986d0f0a1d55131a0)
- [Debugged controlunit.sv to pass 000-020*](https://github.com/booth-algo/RISC-V-T24/commit/466bace0340ff066dbb1aa08de4ab3a05c139f4f)

\* 000-020 refer to the tests in [`tb/c`](../../tb/c)

### Pipeline

- [Implemented stalling](https://github.com/booth-algo/RISC-V-T24/commit/148bc5501a4bda881a9439e73051a85bc7e8068b)
- [Co-solved the lw hazard](https://github.com/booth-algo/RISC-V-T24/commit/a274b6a0809ebd906d5dca6ac9c0f9434b25e5f5)
- [Co-solved the data memory edge case](https://github.com/booth-algo/RISC-V-T24/commit/3b5122d68dd4ef15d340c3e45828db638e97da53)

I worked with Kevin very closely in the pipeline process, primarily in debugging.

### Cache

- [Finished implementation of DM cache](https://github.com/booth-algo/RISC-V-T24/commit/d2e5dc3ac3e5e3af0489dc1b36680a3acf4d5915). 
Co-authored by Kevin. 
- [**Solved the edge case of byte addressing**](https://github.com/booth-algo/RISC-V-T24/commit/2060b0ae0431c7bc4b65d7454ebe4685415ae7da)

The first was co-authored with Kevin. I would also recommend checking out the
last commit (#25), if you had to check one, in which I also wrote the
[data analysis script](../../tb/analyse.py).

## Special Design Decisions

> "Any fool can write code that a computer can understand. 
> Good programmers write code that humans can understand." (Martin Fowler)

The [`def.sv`](../../rtl/def.sv) is a great example to illustrate the point of
translating machine 1s and 0s into human readable text. This also allowed the
control unit and the other unit(s) to share a common interface.

Please see the [testing section](../team_statement_sections/testing.md) for
more information on the unique testing decisions that I have made.

## What I learned

Whilst I did not come into this project empty-handed, I believe that this 
project has been really useful in consolidating my technical skills. I also
got the opportunity to learn a hardware description language, SystemVerilog,
and the RISCV-I ISA.

Working on verification was extremely fun in this environment, in which there
was no *real* pressure to catch every single bug that could slip into 
production. Nevertheless, I persisted and learnt a lot about every aspect of 
the CPU, as it was necessary for me to write well-calibrated 
[tests](../../tb/c/) for every nuance and edge case of the CPU.


## Mistakes I made

> "The only real mistake is the one from which we learn nothing" - Henry Ford

From a technical POV, there were a *lot* of edge cases thay were not caught out 
by the integration tests. For example, here's a case study:

**Case Study**: Cache edge case  
**Test**: [`027-pdf_up_down.c`](../../tb/c/027-pdf_up_down.c)  
**Fixed**: [#25](https://github.com/booth-algo/RISC-V-T24/pull/25)
(same as the commit above: "Solved the edge case of byte adddressing").

The cache, before fixing, would pass every single test case that existed before
027 was written, even [`025-pdf.c`](../../tb/c/025-pdf.c). The need to address
this issue stemed from the reference program looking *slightly* off.

However, even 027 exibited strange behaviour with certain values. At the top of 
the file is this line of code:

```c
// ...
#define SIZE    256
```

The test will pass for values of `SIZE` small enough, such that there is no
need to fetch from main memory or certain values below (below 8).

```c
// ...
for (int ptr = 0; ptr < SIZE; ++ptr)
{
    dataArray[ptr] += 8;
}
```

This behaviour is due to overwriting bytes at the same time as a need to fetch
new data from main memory due to a tag change. The solution is clearly defined
in the RTL: [`dm_cache.sv`](../../rtl/dm_cache.sv).

In conclusion, the takeaway would be that I should have thought more clearly
about the possible edge cases before writing the tests, instead of jumping into
huge integration tests made of 100+ lines of assembly, which would have made the 
debugging easier.

## What I would do differently

- Used the co-authoring function on GitHub for clearer contribution tracking.
- Host formal weekly meetings. We saw each other a lot, but at times, team 
  members would be unaware of changes/responsibilities.
- Branch protected `main`, and squashed commits. This would allow freedom to
  commit as much as one wants, without affecting the main branch history.
- Ensure everyone reads merge requests. This would have been super helpful, as
  it would have fixed the 2 problems listed directly above.

## Other notes

- Thank you to Kevin for helping me to solve the data memory edge case. This 
  took the whole weekend and it would not been possible without you.
