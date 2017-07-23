---
title: Applying DSSS to Kubernetes Development
layout: post
topics: kubernetes learning
---

<link rel='stylesheet' href='/css/kubernetes-dsss.css' />

There are plenty of resources available if you're looking to learn Kubernetes
as either a user or cluster administrator, but if you're getting into
development of Kubernetes _itself_, like I did recently, there are scandalously
few resources to take advantage of and so much more to learn.

{: style="text-align: center"}
_Just looking for the v2 DSSS map? Skip down [here](#map)._

I started diving into Kubernetes about nine months ago as a new developer at
Google, where I work on both Kubernetes and our hosted version, [Google
Container Engine](https://cloud.google.com/container-engine/) (GKE). Even with
a history of containers and cluster environments, the ecosystem around and
within Kubernetes was pretty intimidating. Add to that my need to learn
Google's internal tools and codebase in addition to the open source stack used
for Kubernetes externally, and I knew I needed to be deliberate in my ramp-up.

Feeling overwhelmed, I turned to a systematic framework for accelerated
learning called **DSSS**, from one of my favorite authors, [Tim
Ferriss](http://tim.blog).

If you're unfamiliar with DSSS, [one of Tim's talks
](https://youtu.be/DSq9uGs_z0E?t=578) gives a good introduction, as does his
book, [The 4-Hour Chef](https://www.amazon.com/dp/B005NJU8PA/). The short
version of the acronym is this, though:

{: #dsss-definition }
| Deconstruction | break the domain down into its smallest constituent parts you can learn.
| Selection      | apply the 80/20 rule to filter these down to the 20% parts that yield 80% of the benefit.
| Sequencing     | order the steps intelligently to maximize your learning efficiency.
| Stakes         | make sure you have a good reason not to abandon your learning goal.

I started with an extremely thorough deconstruction of Kubernetes, trying to
capture every meaningful concept and component I could find. This was the
easiest step, since you can crawl the entire known world on the [kubernetes.io
docs](https://kubernetes.io/docs/home/) website and keep a running list. It's
the selection/sequencing steps that require more guidance if you're not already
an expert, so I had to get more creative.

With a combination of shell scripting and manual oversight, I used the
frequency of terms in the documentation as the metric for selection, and the
implicit dependency of concepts for sequencing (i.e. if `A` depends on `B`,
then I need to learn `B` first).

Google pays me to work on Kubernetes, so my job performance and reputation were
already on the line before applying DSSS, so my stakes were covered. No extra
pressure required there. If you're reading this, it's likely that you're also
part of the growing trend to be paid to develop or evaluate Kubernetes for your
company's needs, so you probably already have built-in stakes. If you're
actually an altruistic hobbyist -- then first of all, good on you, and welcome
aboard. It's an exciting place to be. But set some stakes for yourself to make
sure you don't burn out before getting over the hump.

## The Map

All in all, the DSSS exercise (or in my case,
DSS-*oh-my-god-I-hope-I-don't-get-fired*) was beyond useful, and I felt
immensely much more fluent in the overall architecture after using this
systematic approach in short order. Of course, since I cobbled together my
original DSSS map with scripts and statistics, it was far from optimal. Now
that I have much more experience and the gift of hindsight, I've gone back and
refined it in hopes to make the path a little easier to tread for the next
generation of Kubernetes developers.

This map is aimed at ramping up beginners to the project. I may follow up with
an intermediate map later, but as the 80/20 rule of selection implies, this
should get you quite far.

{: #map style="text-align: center"}
### Kubernetes Architecture DSSS Map (beginner) v2.0

{: #map-list}
- [containers](https://www.docker.com/what-container)
- [pods](https://kubernetes.io/docs/concepts/workloads/pods/pod/)
  - podspec
  - health probes
  - init containers
  - volumes
- [kubelet](https://kubernetes.io/docs/admin/kubelet/)
  - static manifests
  - http static manifests
- [kubectl](https://kubernetes.io/docs/user-guide/kubectl-overview/)
  - create / apply / delete
  - get nodes / pods / events
- [kube-apiserver](https://kubernetes.io/docs/admin/kube-apiserver/)
  - api verbs (CRUD + LIST/PATCH)
  - api objects
  - api groups and versioning
  - runtime-config
- [kube-controller-manager](https://kubernetes.io/docs/admin/kube-controller-manager/)
  - controller philosophy
  - replication controller

## But how do I even?

So now you have a map. A DSSS map. Cool, right?

What do you even do with it?

I'm hoping to find the time to write articles for each entry on the map, so
everything on this list just becomes a link to a friendly, easy-to-digest
guided tour of our learning adventure together. For now, though, Google is your
friend, and I've added some friendly-ish links to get jumpstarted. The official
Kubernetes documentation can be pretty dry and excessively self-referential,
but it's still a great start. Download Kubernetes, or sign up for a free-tier
account with GKE or any of the other 7,000* hosted Kubernetes solutions, and
play around.

{: .ast}
_\* slight exaggeration_

Make sure that you learn each concept from the map as thoroughly as you can
before moving onto the next one. That means that in order to strike `kubelet`
off the list, you should have a good understanding of what it is, why it
exists, where and how it gets deployed, its command-line flags, tinker with it
manually, etc.

After completing this map, nearly every other Kubernetes concept is easy to
grok in terms of these basics. What's a `DaemonSet`? A `pod` that runs via
every `kubelet` in the cluster. What's a `Job`? A `pod` that's meant to run to
successful completion (one or more times), so it doesn't just keep restarting
forever. How can I set up ingress rules? Create an `API object` to declare your
policies, and run a `controller` to enforce them.

## Omissions

There were some items that I originally sunk a good deal of time into while
exploring my v1 map that proved useless for this stage of learning. Here are
some things that didn't make the v2 cut:

### etcd

All of the Kubernetes infrastructure state is stored in `etcd`. Done. Cross
that one off your list.

Unless you're a developer on the `kube-apiserver`, or are trying to understand
the nuances of setting up a Highly Available (HA) cluster with redundant
storage, that's really all you need to know. Basically everything else in the
cluster is stateless, and all cluster state is housed in `etcd`.

The rest is certainly _interesting_, of course. `etcd` uses the Raft algorithm
for distributed consensus, which is a conceptual simplification of Paxos that
is functionally equivalent. I found reading about Raft, or how to secure
communications between the `kube-apiserver` and `etcd`, or how `etcd` stores
object version records under the covers all fascinating, but this is all easy
to cull from our map because in reality, only `kube-apiserver` talks to `etcd`,
and everything else just uses the Kubernetes APIs. Focus your energy there
instead.

### kubernetes the hard way

[Kelsey Hightower](https://github.com/kelseyhightower), who is a coworker,
scholar, and a gentleman, has this great repository of instructions for
manually installing and configuring a Kubernetes cluster called
[kubernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way)
(KTHR). It came well recommended to me by teammates and the Internet at large
when I first joined Kubernetes. I think KTHR is a fantastic tool, I really do.
It accomplishes a few things really well:

  1. It helps build empathy for the complexity of Kubernetes and the critical
     need for tooling to automate cluster management.
  2. Following his instructions, you will actually create a functional cluster
     from scratch, which makes it a great guide for codifying this process in a
     way that the official documentation never attempts. Anyone looking to
     build a cluster management tool should consider it the de facto baseline
     for specification.
  3. As an intermediate developer, it can help you understand where processes
     live, how they get configured, what `kubeconfig` is needed to be placed
     where, etc. It's also a useful map of the "known universe" of components
     that can seed the deconstruction step of your own DSSS map and further
     your understanding of the cluster architecture.

KTHR does all of these things really well, but it completely failed as the
purported teaching tool for me as a beginner. I don't think that's how Kelsey
meant for it to be used.
