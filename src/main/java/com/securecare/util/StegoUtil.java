package com.securecare.util;

public class StegoUtil {

    // Zero-width space for '0'
    private static final char ZERO_WIDTH_SPACE = '\u200B';
    // Zero-width non-joiner for '1'
    private static final char ZERO_WIDTH_NON_JOINER = '\u200C';

    public static String hideData(String carrierText, String secretData) {
        StringBuilder binaryRaw = new StringBuilder();
        for (char c : secretData.toCharArray()) {
            binaryRaw.append(String.format("%8s", Integer.toBinaryString(c)).replaceAll(" ", "0"));
        }

        StringBuilder hiddenData = new StringBuilder();
        for (char bit : binaryRaw.toString().toCharArray()) {
            if (bit == '0') {
                hiddenData.append(ZERO_WIDTH_SPACE);
            } else {
                hiddenData.append(ZERO_WIDTH_NON_JOINER);
            }
        }

        // Insert hidden bits in the middle of carrier text for better evasion
        int mid = carrierText.length() / 2;
        return carrierText.substring(0, mid) + hiddenData.toString() + carrierText.substring(mid);
    }

    public static String extractData(String stegoText) {
        StringBuilder extractedBinary = new StringBuilder();

        for (char c : stegoText.toCharArray()) {
            if (c == ZERO_WIDTH_SPACE) {
                extractedBinary.append('0');
            } else if (c == ZERO_WIDTH_NON_JOINER) {
                extractedBinary.append('1');
            }
        }

        // Must be multiple of 8
        if (extractedBinary.length() % 8 != 0) {
            extractedBinary.setLength(extractedBinary.length() - (extractedBinary.length() % 8));
        }

        StringBuilder secretData = new StringBuilder();
        for (int i = 0; i < extractedBinary.length(); i += 8) {
            String byteStr = extractedBinary.substring(i, i + 8);
            if (!byteStr.isEmpty()) {
                int charCode = Integer.parseInt(byteStr, 2);
                secretData.append((char) charCode);
            }
        }
        return secretData.toString();
    }
}
