extern crate itertools;

mod advent_common;
use advent_common::*;
use itertools::Itertools;

fn main() {
    println!("Part1: {}", part1());
    println!("Part2: {}", part2());
}

fn part1() -> i32 {
    steps_to_exit(&mut input(), &constant_offset)
}

fn part2() -> i32 {
    steps_to_exit(&mut input(), &conditional_offset)
}

fn input() -> Vec<i32> {
    input_lines("input\\day5.txt")
        .map(|line| line.unwrap().to_string().parse::<i32>().unwrap())
        .collect_vec()
}

fn steps_to_exit(instructions: &mut Vec<i32>, offset_fn: &Fn(&mut i32)) -> i32 {
    let mut moves: i32 = 0;
    let mut position: i32 = 0;

    while position >= 0 && position < instructions.len() as i32 {
        moves = moves + 1;
        if let Some(instruction) = instructions.get_mut(position as usize) {
            position = position + *instruction;
            offset_fn(instruction)
        }
    }
    moves
}

fn constant_offset(instruction: &mut i32) {
    *instruction += 1;
}

fn conditional_offset(instruction: &mut i32) {
    if *instruction >= 3 {
        *instruction -= 1;
    } else {
        *instruction += 1;
    }
}


#[cfg(test)]
mod day5_tests {
    use super::*;

    #[test]
    fn steps_to_exit_test() {
        let mut vec: Vec<i32> = vec![0, 3, 0, 1, -3];
        assert_eq!(steps_to_exit(&mut vec, &constant_offset), 5);
    }

    #[test]
    fn steps_to_exit_with_conditional_offset_test() {
        let mut vec: Vec<i32> = vec![0, 3, 0, 1, -3];
        assert_eq!(steps_to_exit(&mut vec, &conditional_offset), 10);
    }

}