# Portfolio 5: Distributed and Cloud Database Exercise

## 1. Introduction

This portfolio explores distributed and cloud database concepts using Fabbyent, a simulated e-commerce business. The practical exercise uses MongoDB Atlas to examine a cloud-hosted database deployment and the role of replica sets in availability and data redundancy.

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

The Atlas Metrics page displays three cluster members. At the time of observation, two members were marked Secondary (S), while one was marked Primary (P).

In a MongoDB replica set, the Primary accepts writes and records changes in the database's operation log. Secondary members replicate those changes from the Primary. This architecture supports data redundancy and can support automatic failover if the Primary becomes unavailable and the remaining members can elect a new Primary.

The screenshot `evidence/01_atlas_replica_set_metrics.png` records the observed member roles and their operation-counter charts.

## 4. Availability and Fault Tolerance

A multi-member replica set reduces reliance on a single database server. If the Primary becomes unavailable, eligible remaining members can elect a replacement Primary. Applications must still handle temporary interruptions and reconnect appropriately.

This portfolio documents the configured replica-set architecture. A forced failover test has not been performed, so successful failover and recovery have not been independently verified.

## 5. Monitoring and Observations

The Atlas Metrics page provides separate operation-counter charts for each cluster member. These charts help an administrator inspect database activity across the replica set.

The captured screenshot shows low operation-counter activity during the displayed one-hour period. These measurements describe the observed period only; they do not establish performance under heavy e-commerce traffic.

## 6. Benefits and Limitations

### Benefits

- Cloud-hosted database infrastructure.
- Multiple replica-set members provide data redundancy.
- Election-based recovery can improve availability after a Primary failure.
- Atlas metrics provide visibility into member activity.

### Limitations

- Replication does not replace independent backups.
- Failover may cause a temporary interruption.
- High availability does not guarantee zero data loss in every failure scenario.
- The practical exercise did not include a controlled failover or recovery test.
- The observed metrics do not demonstrate performance under production-level load.

## 7. Evidence

- `evidence/01_atlas_replica_set_metrics.png` — Atlas Metrics screenshot showing the three members, their observed roles, cloud region, MongoDB version, and operation-counter charts.

## 8. Conclusion

The exercise demonstrates how MongoDB Atlas provides a managed cloud database environment and how a three-member replica set supports replication and availability. The captured evidence documents the observed deployment and member roles. Further testing would be required to verify failover behaviour, recovery time, and application continuity under failure conditions.
