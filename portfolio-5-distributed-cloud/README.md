# Portfolio 5: Distributed and Cloud Database Exercise

## 1. Introduction

This portfolio explores distributed and cloud database concepts using Fabbyent, a simulated e-commerce business. The practical exercise uses MongoDB Atlas to examine a cloud-hosted database deployment and the role of replica sets in data redundancy and availability.

## 2. Cloud Database Environment

The MongoDB Atlas environment has the following configuration:

| Property        | Observed configuration      |
| --------------- | --------------------------- |
| Cloud provider  | Amazon Web Services (AWS)   |
| Region          | Paris, France (`eu-west-3`) |
| Cluster name    | Cluster0                    |
| MongoDB version | 8.0.34                      |
| Deployment      | Three-member replica set    |
| Database        | `fabbyent_nosql`            |
| Collection      | `orders`                    |

## 3. Replica Set Architecture

The MongoDB Atlas Metrics page displays three cluster members. At the time of observation, one member was marked Primary (P), while two members were marked Secondary (S).

In a MongoDB replica set, the Primary accepts write operations and records changes in the operation log (oplog). Secondary members replicate these changes from the Primary. This architecture provides data redundancy and can support automatic failover if the Primary becomes unavailable and the remaining members can elect a new Primary.

The screenshot `evidence/01_atlas_replica_set_metrics.png` documents the observed member roles and their operation-counter charts.

## 4. Availability and Fault Tolerance

A multi-member replica set reduces reliance on a single database server. If the Primary becomes unavailable, eligible remaining members can elect a replacement, provided the election requirements are met. Applications must still handle temporary interruptions and reconnect appropriately.

This portfolio documents the configured replica-set architecture. A forced failover test was not performed; therefore, successful failover, recovery time, and application continuity were not independently verified.

## 5. Monitoring and Observations

The Atlas Metrics page provides separate operation-counter charts for each cluster member. These charts help administrators observe database activity across the replica set.

The captured screenshot shows low operation-counter activity during the displayed one-hour period. These measurements describe the observed period only and do not establish performance under heavy e-commerce traffic.

## 6. Sharding and Horizontal Scalability

MongoDB supports sharding, which distributes data across multiple shards to support larger datasets and workloads. Sharding differs from replication: replication maintains copies of data across replica-set members, while sharding partitions data across shards.

The practical exercise examined a three-member replica set. Sharding was not configured or tested during this exercise. For Fabbyent, sharding could be evaluated in the future if order data or traffic grows beyond what a single replica set can comfortably support.

Selecting an appropriate shard key would require consideration of query patterns, data distribution, and workload requirements.

## 7. Data Consistency

MongoDB replica sets replicate changes from the Primary to Secondary members. Replication is asynchronous, so a Secondary may temporarily lag behind the Primary. Read preference and write concern settings influence where reads are served from and the acknowledgement and durability guarantees of writes.

For Fabbyent, order and payment operations would require appropriate consistency and durability settings to reduce the risk of acting on stale data or losing acknowledged writes in certain failure scenarios.

These settings were not independently configured or tested as part of this exercise. Their discussion therefore represents the relevant database concepts rather than a verified experimental result.

## 8. Benefits and Limitations

### Benefits

- Cloud-hosted database infrastructure managed through MongoDB Atlas.
- Multiple replica-set members provide data redundancy.
- Election-based recovery can improve availability after a Primary failure.
- Atlas metrics provide visibility into member activity.
- MongoDB supports sharding for future horizontal scalability if required.

### Limitations

- Replication does not replace independent backups.
- Failover may cause a temporary interruption.
- High availability does not guarantee zero data loss in every failure scenario.
- The practical exercise did not include a controlled failover or recovery test.
- Sharding and consistency settings were discussed but not experimentally tested.
- The observed metrics do not demonstrate performance under production-level load.

## 9. Evidence

- `evidence/01_atlas_replica_set_metrics.png` — Atlas Metrics screenshot showing the three cluster members, their observed roles, cloud region, MongoDB version, and operation-counter charts.

## 10. Conclusion

This exercise demonstrates how MongoDB Atlas provides a managed cloud database environment and how a three-member replica set supports replication and availability. It also examines the roles of sharding in horizontal scalability and consistency settings in reliable data access.

The captured evidence documents the observed deployment and member roles. Further practical testing would be required to verify failover behaviour, recovery time, consistency settings, and application continuity under failure conditions. Sharding would require a separate design and implementation exercise before its benefits for Fabbyent could be evaluated.
