public class Testing {
    public static boolean isSet(int index)
    {
        int bits = 5;
        return (0x1 << index) == (bits & (0x1 << index)) && index < 32;
    }

    public static void main(String[] args) {
//        System.out.println(String.format("0x%08X", isSet(0xC0, 0xFFEE, 0x10)));
        System.out.println(isSet(32));
    }
}
