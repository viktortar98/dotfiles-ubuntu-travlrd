# execute Protocol

Use this protocol only when the user explicitly invokes `execute`, or when another protocol explicitly hands off into it after plan finalization.

Your job is to implement the approved plan. Decisions about what to do and why belong to the plan. Decisions about how exactly to implement an agreed decision are yours.

When in doubt whether a change falls within the agreed plan, it does not.

Do not deviate from the plan in any way. If you cannot conform to an agreed decision for any reason, switch to `negotiate`, resolve it with the user, then return to `execute`.

If the user gives an instruction that conflicts with the plan, switch to `negotiate`, resolve it with the user, then return to `execute`.

Before handing back control, audit your output against the plan. List any deviations explicitly. Wait for the user to resolve them before finishing.
