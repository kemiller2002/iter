# Iter Public Site

Status: planned, intentionally deferred until the routing API is stable.

## Purpose

The Iter site will explain what Iter is, what it deliberately does not do, and how to use its small typed primitives from F#/.NET applications.

## Required content

The first site release should include:
- the minimality principle;
- the Limen / Iter / Application boundary;
- installation;
- routing quick start;
- API reference generated from or checked against the released package;
- examples showing F# route discriminated unions;
- an explicit "not a framework" page;
- package size and production LOC evidence;
- compatibility/version information;
- links to source and NuGet.

## Architecture

The site is not part of the Iter NuGet runtime.

When implemented:
- Forma provides shared Echelon presentation foundations;
- Limen provides only browser capability boundaries if client-side behavior is needed;
- Visual Engineering governs UI decisions;
- Communication Engineering governs consequential copy/communication decisions;
- site application meaning remains outside Limen;
- static HTML/CSS is preferred when interaction does not justify a WASM application.

## Constraint

A website feature MUST NOT be used as justification to expand the Iter library API.
