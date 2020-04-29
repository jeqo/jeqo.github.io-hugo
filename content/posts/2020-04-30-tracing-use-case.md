---
title: The distributed-tracing use-case
date: 2020-04-30
section: posts
tags:
- zipkin
categories:
- event-driven
- distributed-tracing
- observability
draft: true
---

This post is an attempt to share my thoughts--and hopefully serve as an introduction--about distributed tracing; and is meant to be used as a reference when writing about other topics as I use to come back to it.

While contributing to the Openzipkin community, one reason I'm still engaged with it--apart from the awesome group of people that I've ended up working with--is how _complete_ the scope of the technology is. From instrumentating different frameworks, and integrating with multiple back-ends and databases, to different levels of abstractions and protocol design, and dealing with multiple programming language, scalability, cardinality, to experiment with stream-processing and machine-learning. It's overwhelming, challenging, but also fun. It has tought me a lot, and also give me _a escuse_ to experiment with different technologies. 

<!--more-->

Let's start with **distributed**. 

_Tracing_ is used in different context. The meaning I prefer to give is: producing evidence to understand a trajectory.

Then, Distributed-Tracing is about producing evidence to understand the trajectory of interactions between distributed components.

The evidence--the _trace_--