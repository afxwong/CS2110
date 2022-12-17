/**
 * CS 2110 Fall 2021 HW1
 * Part 2 - Coding with bases
 *
 * @author Anthony Wong
 *
 * Global rules for this file:
 * - You may not use more than 2 conditionals per method. Conditionals are
 *   if-statements, if-else statements, or ternary expressions. The else block
 *   associated with an if-statement does not count toward this sum.
 * - You may not use more than 2 looping constructs per method. Looping
 *   constructs include for loops, while loops and do-while loops.
 * - You may not use nested loops.
 * - You may not declare any file-level variables.
 * - You may not use switch statements.
 * - You may not use the unsigned right shift operator (>>>)
 * - You may not write any helper methods, or call any method from this or
 *   another file to implement any method. Recursive solutions are not
 *   permitted.
 * - The only Java API methods you are allowed to invoke are:
 *     String.length()
 *     String.charAt()
 * - You may not invoke the above methods from string literals.
 *     Example: "12345".length()
 * - When concatenating numbers with Strings, you may only do so if the number
 *   is a single digit.
 *
 * Method-specific rules for this file:
 * - You may not use multiplication, division or modulus in any method, EXCEPT
 *   decimalStringToInt (where you may use multiplication only)
 * - You may declare exactly one String variable each in intToHexString and
 *   and binaryStringToOctalString.
 */
public class Bases
{
    /**
     * Convert a string containing ASCII characters (in binary) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid binary numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: binaryStringToInt("111"); // => 7
     */
    public static int binaryStringToInt(String binary)
    {
        int ret = 0;
        for (int i = 0; i < binary.length(); i++) {
            ret = (ret << 1) + binary.charAt(i) - 48;
        }
        return ret;
    }

    /**
     * Convert a string containing ASCII characters (in decimal) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid decimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: decimalStringToInt("46"); // => 46
     *
     * You may use multiplication in this method.
     */
    public static int decimalStringToInt(String decimal)
    {
        int ret = 0;
        int ptr = 1;
        for (int i = decimal.length() - 1; i >= 0; i--) {
            ret += (decimal.charAt(i) - 48) * ptr;
            ptr *= 10;
        }
        return ret;
    }

    /**
     * Convert a string containing ASCII characters (in octal) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid octal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: octalStringToInt("27"); // => 23
     */
    public static int octalStringToInt(String octal)
    {
        int ret = 00;
        for (int i = 0; i < octal.length(); i++) {
            ret = (ret << 3) + octal.charAt(i) - 48;
        }
        return ret;
    }

    /**
     * Convert a int into a String containing ASCII characters (in hex).
     *
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters
     * necessary to represent the number that was passed in.
     *
     * Example: intToHexString(166); // => "A6"
     *
     * You may declare one String variable in this method.
     */
    public static String intToHexString(int hex)
    {
        String ret = "";
        if (hex == 0) {
            return "0";
        }
        while (hex != 0) {
            int rightdigit = hex & 0xF;
            if (rightdigit <= 9) {
                ret = ((char) (48 + rightdigit)) + ret;
            } else {
                ret = (char) (('A' + rightdigit - 10)) + ret;
            }
            hex = hex >> 4;
        }
        return ret;
    }

    /**
     * Convert a String containing ASCII characters representing a number in
     * binary into a String containing ASCII characters that represent that same
     * value in octal.
     *
     * The output string should only contain numbers.
     * You do not need to handle negative numbers.
     * The length of all the binary strings passed in will be of size 24.
     * The octal string returned should contain 8 characters.
     *
     * Example: binaryStringToOctalString("000001101010000111100100"); // => "01520744"
     *
     * You may declare one String variable in this method.
     */
    public static String binaryStringToOctalString(String binary)
    {
        String ret = "";
        int bin = 0;
        for (int i = 0; i < binary.length(); i++) {
            bin = (bin << 1) + binary.charAt(i) - 48;
        }
        while (bin != 0 || ret.length() != 8) {
            int rightdigit = bin & 0b111;
            ret = (char) (48 + rightdigit) + ret;
            bin = bin >> 3;
        }
        return ret;
    }
}
