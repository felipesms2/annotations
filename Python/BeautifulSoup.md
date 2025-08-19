#   Download all images from website

#   pip install beautifulsoup4 requests urllib3
 
 ```python
 import os
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse

def download_images_from_url(url, output_folder):
    """
    Extract all images from a webpage URL and download them to a specified folder.
    
    Args:
        url (str): URL of the webpage to scrape
        output_folder (str): Folder where images will be saved
    """
    
    # Create output folder if it doesn't exist
    os.makedirs(output_folder, exist_ok=True)
    
    try:
        # Fetch the HTML content
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        
        # Parse the HTML with BeautifulSoup
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # Find all image tags
        img_tags = soup.find_all('img')
        
        if not img_tags:
            print("No images found on the webpage.")
            return
        
        print(f"Found {len(img_tags)} images on the webpage.")
        
        # Download each image
        for i, img in enumerate(img_tags, 1):
            img_url = img.get('src') or img.get('data-src')
            if not img_url:
                continue
                
            # Handle relative URLs
            img_url = urljoin(url, img_url)
            
            try:
                # Get the image filename
                parsed_url = urlparse(img_url)
                filename = os.path.basename(parsed_url.path)
                
                # If no proper filename, create one
                if not filename:
                    filename = f"image_{i}.jpg"
                else:
                    # Clean the filename
                    filename = ''.join(c for c in filename if c.isalnum() or c in ('.', '_', '-'))
                
                # Download the image
                img_response = requests.get(img_url, stream=True, headers=headers)
                img_response.raise_for_status()
                
                # Determine content type for extension
                content_type = img_response.headers.get('content-type', '').split('/')[-1]
                if content_type in ['jpeg', 'png', 'gif', 'webp']:
                    if '.' not in filename:
                        filename = f"{filename}.{content_type}"
                    elif not filename.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.webp')):
                        filename = f"{os.path.splitext(filename)[0]}.{content_type}"
                
                # Save the image
                filepath = os.path.join(output_folder, filename)
                
                # Handle duplicate filenames
                counter = 1
                while os.path.exists(filepath):
                    name, ext = os.path.splitext(filename)
                    filepath = os.path.join(output_folder, f"{name}_{counter}{ext}")
                    counter += 1
                
                with open(filepath, 'wb') as f:
                    for chunk in img_response.iter_content(1024):
                        f.write(chunk)
                
                print(f"Downloaded ({i}/{len(img_tags)}): {filename}")
                
            except Exception as e:
                print(f"Failed to download {img_url}: {str(e)}")
    
    except Exception as e:
        print(f"Error accessing {url}: {str(e)}")

# Example usage
if __name__ == "__main__":
    target_url = "https://example.com"  # Replace with your target URL
    download_folder = "downloaded_images"  # Folder where images will be saved
    
    download_images_from_url(target_url, download_folder)
``` 

