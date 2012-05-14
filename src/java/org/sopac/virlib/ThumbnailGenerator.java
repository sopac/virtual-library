package org.sopac.virlib; /**
 * Created by IntelliJ IDEA.
 * User: sachin
 * Date: 2/21/12
 * Time: 6:17 PM
 * To change this template use File | Settings | File Templates.
 */

import com.sun.pdfview.PDFFile;
import com.sun.pdfview.PDFPage;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.Arrays;

public class ThumbnailGenerator {

    public static void generateThumbnailPDF(String pdfPath, String outDirectory, String outJpgFile) {
        try {
            File pdfFile = new File(pdfPath);
            System.out.println("Generating Thumnail - " + pdfFile.getName());
            RandomAccessFile raf = new RandomAccessFile(pdfFile, "r");
            FileChannel channel = raf.getChannel();
            ByteBuffer buf = channel.map(FileChannel.MapMode.READ_ONLY, 0, channel.size());
            PDFFile pdf = new PDFFile(buf);
            PDFPage page = pdf.getPage(0);

            // create the image
            Rectangle rect = new Rectangle(0, 0, (int) page.getBBox().getWidth(), (int) page.getBBox().getHeight());
            BufferedImage bufferedImage = new BufferedImage(rect.width, rect.height, BufferedImage.TYPE_INT_RGB);

            Image image = page.getImage(rect.width, rect.height, // width &
                    // height
                    rect, // clip rect
                    null, // null for the ImageObserver
                    true, // fill background with white
                    true // block until drawing is done
            );
            Graphics2D bufImageGraphics = bufferedImage.createGraphics();
            bufImageGraphics.drawImage(image, 0, 0, null);

            //resize output
            //bufferedImage = resizeImage(bufferedImage, BufferedImage.TYPE_INT_RGB);

            File of = new File(outDirectory + "/" + outJpgFile);
            if (of.exists()) of.delete();
            ImageIO.write(bufferedImage, "jpg", of);


            //mogrify
            ProcessBuilder pb = new ProcessBuilder();
            String mogrify_path = "/opt/local/bin/mogrify";
            String os = System.getProperty("os.name");
            if (os.toLowerCase().trim().equals("linux")) mogrify_path = "/usr/bin/mogrify";
            String[] command = {mogrify_path, "-resize", "200x", outDirectory + "/" + outJpgFile};
            pb.command(command);
            pb.directory(new File(outDirectory));
            Process p = pb.start();
            //Read out dir output
            InputStream is = p.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String line;
            System.out.printf("Output of running %s is:\n", Arrays.toString(command));
            while ((line = br.readLine()) != null) {
                System.out.println("mogrify -> " + line);
            }
            //Wait to get exit value
            try {
                int exitValue = p.waitFor();
                System.out.println("\n\nExit Value is " + exitValue);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            System.out.println("Finished Thumbnail Generation - " + outJpgFile);

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    public static void resize(String filePath) {
        try {
            ProcessBuilder pb = new ProcessBuilder();
            String mogrify_path = "/opt/local/bin/mogrify";
            String os = System.getProperty("os.name");
            if (os.toLowerCase().trim().equals("linux")) mogrify_path = "/usr/bin/mogrify";
            String[] command = {mogrify_path, "-resize", "200x", filePath};
            pb.command(command);
            pb.directory(new File(filePath.substring(0, filePath.lastIndexOf("/"))));
            Process p = pb.start();
            //Read out dir output
            InputStream is = p.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String line;
            System.out.printf("Output of running %s is:\n", Arrays.toString(command));
            while ((line = br.readLine()) != null) {
                System.out.println("mogrify -> " + line);
            }
            //Wait to get exit value
            int exitValue = p.waitFor();
            System.out.println("\n\nThumbnail Resized .Exit Value is " + exitValue);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    //quality of resized image is bad (using mogrify instead)
    private static BufferedImage resizeImage(BufferedImage originalImage, int type) {
        int IMG_WIDTH = 200;
        int IMG_HEIGHT = 280;
        BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
        Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
        g.dispose();
        g.setComposite(AlphaComposite.Src);

        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
                RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        g.setRenderingHint(RenderingHints.KEY_RENDERING,
                RenderingHints.VALUE_RENDER_QUALITY);
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                RenderingHints.VALUE_ANTIALIAS_ON);

        return resizedImage;
    }
}
