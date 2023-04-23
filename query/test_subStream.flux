import "generate"
import "date"
import "join"

subStream = (A=<-, count, offset1) => {
    return A
            |> limit(n: count, offset: offset1)
}

baros = from(bucket: "FirstBucket")
    |> range(start: 0)
    |> filter(fn: (r) => r._measurement == "airSensors")
    |> filter(fn: (r) => r._field == "baro")
    |> map(
        fn: (r) => {
            return {"_value": r._value, "_time": date.truncate(t: r._time, unit: 30m)}
        },
    )

otwos =
    from(bucket: "FirstBucket")
        |> range(start: 0)
        |> filter(fn: (r) => r._measurement == "airSensors")
        |> filter(fn: (r) => r._field == "otwo")
        |> limit(n: 200, offset: 0)
        |> map(
            fn: (r) => {
                return {"_value": r._value, "_time": date.truncate(t: r._time, unit: 30m)}
            },
        )


pearsonr(on: ["_time"], x: subStream(A: baros, count: 200, offset1 : 0), y: otwos )