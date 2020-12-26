import ImageURL from "../../style/ResourceMainURL.scss";

// using substring because
// ImageURL.resourceURL consist of " for the first and last character of the link
// eg: 
//      ImageURL.resourceURL = "www.go-bites.com"
//      required only www.go-bites.com

const resourceURL = ImageURL.resourceURL.substring(1, ImageURL.resourceURL.length - 1);

export default resourceURL;