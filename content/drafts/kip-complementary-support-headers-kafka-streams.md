---
title: "KIP: Complementary support for headers in Kafka Streams"
date: 2020-05-31
---

## Motivation

Headers are transiently passed over a Kafka Streams topology. To act on them, Topology API has to be used ([KIP-244](https://cwiki.apache.org/confluence/display/KAFKA/KIP-244%3A+Add+Record+Header+support+to+Kafka+Streams+Processor+API)).

Although current support is useful for instrumentation, it becomes cumbersome to use headers for traditional Kafka Streams DSL operations (e.g filtering based on header value).

Related JIRA issue: <https://issues.apache.org/jira/browse/KAFKA-7718>

## Proposed Changes

1. Include KStreams operator to map headers into a value pair: `ValueAndHeaders`.
1. Include `ValueAndHeaders` serde to serialize values if needed.
1. Include KStreams operator to set and remove headers.

```java

public class ValueAndHeaders <V> {
    private final V value;
    private final Headers headers;

    //...
}

public class ValueAndHeadersSerde<V> {
}

public interface SetHeadersAction<K, V> {
    Iterable<Header> apply(final K key, final V value);
}

public interface SetHeaderAction<K, V> {
    Header apply(final K key, final V value);
}

public class KStream {
    //...
    KStream<K, V> setHeaders(final SetHeadersAction<? super K, ? super V> action, final Named named);

    KStream<K, V> setHeaders(final SetHeadersAction<? super K, ? super V> action);

    KStream<K, V> setHeader(final SetHeaderAction<? super K, ? super V> action, final Named named);

    KStream<K, V> setHeader(final SetHeaderAction<? super K, ? super V> action);

    KStream<K, V> removeHeaders(final Iterable<String> headerKeys, final Named named);

    KStream<K, V> removeHeaders(final Iterable<String> headerKeys);

    KStream<K, V> removeHeader(final String headerKey, final Named named);

    KStream<K, V> removeHeader(final String headerKey);

    KStream<K, ValueAndHeaders<V>> withHeaders(final Named named);

    KStream<K, ValueAndHeaders<V>> withHeaders();
    //...
}
```

This APIs will allow usages similar to:

```java
kstream.withHeaders()
       .filter((k, v) -> v.headers().lastValue())

kstream.withHeaders()
       .map((k, v) -> v.headers().add("foo", "bar".getBytes()))
       .setHeaders((k, v) -> v.headers())
       .to("output")
```

## Compatibilily, Deprecation, and Migration Plan

* New functions will be supported since 2.0+, as KIP-244 adopted.
* No existing stores or functions are affected.

## Rejected alternatives

1. Expand `KeyValue` to support headers. This will affect all current APIs, from KStream/KTable to Stores.