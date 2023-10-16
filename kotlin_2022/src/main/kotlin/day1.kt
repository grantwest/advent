import java.io.File

fun main(args: Array<String>) {
    val mostCalories =
    File("../input/2022/day1.txt")
        .readText()
        .split("\n\n")
        .map { calorieGroup ->
            calorieGroup
                .split("\n")
                .map { it.toInt() }
        }
        .map { it.sum() }
        .max()

    println(mostCalories)

    // Part 2
    val sumOfTop3 =
        File("../input/2022/day1.txt")
            .readText()
            .split("\n\n")
            .map { calorieGroup ->
                calorieGroup
                    .split("\n")
                    .map { it.toInt() }
            }
            .map { it.sum() }
            .sorted()
            .takeLast(3)
            .sum()

    println(sumOfTop3)
}