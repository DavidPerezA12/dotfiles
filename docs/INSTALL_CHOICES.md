# Asking what to install

Use this conversation flow on both a client Mac and a server. Write to the
user in Spanish, in short, concrete sentences. Inspect first, then ask about
choices the current conversation has not already settled.

## Start with the machine and intended use

State which Mac is being configured, its role and the relevant tools already
installed. Then ask about intended work, rather than presenting every package
in the repository as a required installation. For example:

> Estoy revisando este Mac como cliente/servidor. Ya tienes Git y el editor
> funcionando. ¿Qué quieres desarrollar aquí: Android, iOS/macOS, web/backend
> u otras cosas? ¿Necesitas ejecutar emuladores o servicios locales también?

Use the actual inspection, not these sample facts. A workload already selected
by the user does not need another approval question. For the mini, follow
Serverfiles' `docs/DEVELOPMENT.md` for the workload-specific choices.

## Offer one manageable block

Group related tools: terminal/editor, development workloads, coding agents,
desktop apps, remote access, monitoring and system settings. Describe each
proposed block in terms of what it lets the user do. List the actual missing
tools, their source, large downloads, paid licences and manual permissions.

> Para Android te faltan estas herramientas de compilación: [lista real].
> El emulador y sus imágenes se eligen aparte y ocupan [tamaño comprobado].
> ¿Instalo solo lo necesario para compilar, añado también el emulador o
> dejamos Android fuera de este Mac?

Offer “install”, “omit” and narrower alternatives where useful. Avoid one
question per dependency and avoid a long questionnaire for every block at
once. Do not invent download sizes, versions or pricing. If unknown, say so.

## Apply only the agreed selection

Record and carry forward the selection. Once the user has selected a block
and its effects are clear, complete it without asking the same question again.
An omitted workload is expected, not a reason to install it later to make
the two Macs identical.

Before running a command, ensure all its effects fit the selection. Choosing
Android or web development alone does not select the entire Brewfile, every
coding agent or the full installer. Partial choices use individual selected
packages; `--links-only` can apply shared config without installing tools.
The complete installer or app bundle requires selecting all their effects.

Wispr Flow belongs on the MacBook client and is excluded from the Mac mini.
AlDente is laptop-only. Neither should be offered as a missing server tool.

## Verify and explain the result

After each block, state what works and what failed. If a password, login or
permission is needed, give the exact app/step/command and let the user enter
credentials there. Never ask for a secret in chat. Keep the remaining work
clear without requesting another confirmation for completed choices.

For remote access, provide real links with their host and test status using
Serverfiles' `docs/CONNECTIONS.md`. Finish with installed and verified items,
failed items with their errors, and pending manual steps.
