# The `meta-balena` branch

This branch is the balenaOS integration adapter for this layer.
[balena-seeed-cm4](https://github.com/Seeed-Studio/balena-seeed-cm4) consumes
it as the `layers/meta-seeed-cm4` git submodule (see `.gitmodules` there),
following the pattern established by
[meta-seeed-rockchip](https://github.com/Seeed-Studio/meta-seeed-rockchip) /
[balena-seeed-rockchip](https://github.com/Seeed-Studio/balena-seeed-rockchip).

## Rules

1. **`main` is the single source of truth for board support.** Machine
   configs, kernels, drivers and device tree overlays are fixed on `main`
   only. This branch never carries board fixes of its own.
2. **Only balena-specific glue lives here** — the small set of things that
   are meaningless or harmful outside a balenaOS build (currently: the
   standalone u-boot `boot.scr` bootcmd override is not injected, see
   `recipes-bsp/u-boot/u-boot_%.bbappend`).
3. **Keep the delta tiny.** The intended size of
   `git diff main..meta-balena` is tens of lines. A change that grows beyond
   that belongs either on `main` (if it is board support) or in the balena
   repo's delta layer (`layers/meta-balena-raspberrypi` in balena-seeed-cm4,
   if it is balena integration glue).

Note: some recipes here also apply under balenaOS and compose with the delta
layer's appends (e.g. `rpi-config_git.bbappend` writes config.txt lines in
both environments). Differences in *behavior* between the standalone and
balena builds that cannot be expressed as delta-layer appends are the only
candidates for this branch.

## Maintenance

Regularly merge `main` into this branch (the delta is small, so conflicts
are rare):

    git checkout meta-balena && git merge origin/main

balena-seeed-cm4 pins this branch via its submodule reference; Renovate (or
a manual submodule bump) picks new commits up and triggers the
`seeed-balena-boards-build` workflow there. Board-level validation happens
in the standalone CI on `main`; the balena repo rebuilds and re-tests the
balenaOS-specific domains (boot chain, supervisor, hostapp updates) on the
device after each bump.
